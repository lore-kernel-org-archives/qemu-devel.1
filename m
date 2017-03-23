Received: from eggs.gnu.org ([2001:4830:134:3::10]:53167)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cr0Y7-0003AZ-20
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 07:05:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cr0Y6-0001S3-6T
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 07:04:59 -0400
Received: from mail-wm0-x234.google.com ([2a00:1450:400c:c09::234]:33159)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cr0Y6-0001Rz-13
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 07:04:58 -0400
Received: by mail-wm0-x234.google.com with SMTP id v203so1276103wmg.0
	for <qemu-devel@nongnu.org>; Thu, 23 Mar 2017 04:04:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170322125438.6235-1-stefanha@redhat.com>
References: <20170322125438.6235-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 Mar 2017 11:04:36 +0000
Message-ID: <CAFEAcA_v8V2K47L_nQWcOV2k7KreH7p94t0rKzpZBcMM=mL1KA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL for-2.9 0/1] Block patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 22 March 2017 at 12:54, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> The following changes since commit 940a8ce075e3408742a4edcabfd6c2a15e2539eb:
>
>   Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2017-03-20 16:34:26 +0000)
>
> are available in the git repository at:
>
>   git://github.com/stefanha/qemu.git tags/block-pull-request
>
> for you to fetch changes up to ff5bbe56c6f9a74c2d77389a21d5d2368458c939:
>
>   parallels: fix default options parsing (2017-03-21 10:02:36 +0000)
>
> ----------------------------------------------------------------
>
> ----------------------------------------------------------------
>
> Edgar Kaziahmedov (1):
>   parallels: fix default options parsing
>
>  block/parallels.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- PMM
