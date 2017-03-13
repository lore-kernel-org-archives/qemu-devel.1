Received: from eggs.gnu.org ([2001:4830:134:3::10]:38028)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cnPq6-0003kl-Nj
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 09:16:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cnPq5-0006aa-Ou
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 09:16:42 -0400
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:36487)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cnPq5-0006aQ-JT
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 09:16:41 -0400
Received: by mail-wm0-x231.google.com with SMTP id n11so40057176wma.1
	for <qemu-devel@nongnu.org>; Mon, 13 Mar 2017 06:16:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170310072051.15704-1-famz@redhat.com>
References: <20170310072051.15704-1-famz@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 13 Mar 2017 14:16:20 +0100
Message-ID: <CAFEAcA_xgaUVZ8YK9Zjg44vAZ3=jQwy+C1Kcr9F-w-JCOoATvA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 0/2] Docker patches for 2.9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 10 March 2017 at 08:20, Fam Zheng <famz@redhat.com> wrote:
> The following changes since commit eba44e9339fc13c36e24c8c59e2b73ea231b46a1:
>
>   Merge remote-tracking branch 'remotes/jasowang/tags/net-pull-request' into staging (2017-03-06 15:13:23 +0000)
>
> are available in the git repository at:
>
>   git://github.com/famz/qemu.git tags/docker-pull-request
>
> for you to fetch changes up to 8ba1e5f72b17584f23e17c54494bb4beeb05174e:
>
>   docker/dockerfiles/debian-s390-cross: include clang (2017-03-10 15:05:22 +0800)
>
> ----------------------------------------------------------------
>
> Hi Peter, here are two more docker patches:
>
> - Fix for shippable.
> - Improvement on proxy env var. Technically it's not a fix but since it's under
>   tests/, it doesn't have to wait for the 2.10 window.
>

Applied, thanks.

-- PMM
