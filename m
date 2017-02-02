Received: from eggs.gnu.org ([2001:4830:134:3::10]:37419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cZE1S-0000w5-JQ
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 04:49:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cZE1R-0007Cz-Gc
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 04:49:46 -0500
Received: from mail-vk0-x22e.google.com ([2607:f8b0:400c:c05::22e]:33508)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cZE1R-0007Cp-8Z
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 04:49:45 -0500
Received: by mail-vk0-x22e.google.com with SMTP id k127so7066119vke.0
	for <qemu-devel@nongnu.org>; Thu, 02 Feb 2017 01:49:45 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1485877831-28786-1-git-send-email-kraxel@redhat.com>
References: <1485877831-28786-1-git-send-email-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 2 Feb 2017 09:49:23 +0000
Message-ID: <CAFEAcA-wqKtfanrVYnyaWv6m=xYvV5=3gbsJ4JbzkrJwegd-BQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL v2 00/11] ui patch queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 31 January 2017 at 15:50, Gerd Hoffmann <kraxel@redhat.com> wrote:
>   Hi,
>
> Here comes the ui patch queue.  Nothing outstanding here.  Bugfixes and
> small improvements all user interfaces.
>
> v2 updates:
>   * change "C.utf-8" locale to "C.UTF-8".
>   * add forgotten "fix console resize" patch.
>
> please pull,
>   Gerd
>
> The following changes since commit a0def594286d9110a6035e02eef558cf3cf5d847:
>
>   Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2017-01-30 10:23:20 +0000)
>
> are available in the git repository at:
>
>
>   git://git.kraxel.org/qemu tags/pull-ui-20170131-2
>
> for you to fetch changes up to 3ef0c573d37b117867352a8bd8c567d3b774fe37:
>
>   console: fix console resize (2017-01-31 16:09:16 +0100)
>
> ----------------------------------------------------------------
> ui: bugfixes and small improvements all over the place.
>

Applied, thanks.

-- PMM
