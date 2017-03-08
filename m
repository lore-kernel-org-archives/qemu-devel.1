Received: from eggs.gnu.org ([2001:4830:134:3::10]:45025)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1clcuF-00028q-Ew
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 09:49:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1clcuE-00050P-Di
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 09:49:35 -0500
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:37734)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1clcuE-00050D-7I
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 09:49:34 -0500
Received: by mail-wm0-x22c.google.com with SMTP id n11so32763297wma.0
	for <qemu-devel@nongnu.org>; Wed, 08 Mar 2017 06:49:34 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1488901251-16214-1-git-send-email-kwolf@redhat.com>
References: <1488901251-16214-1-git-send-email-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 8 Mar 2017 15:49:12 +0100
Message-ID: <CAFEAcA8siFJuTLKZdBiBgLGiuWdMMZSvS0c1QymrzsjWNRVGPA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 00/27] Block layer fixes for 2.9.0-rc0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 7 March 2017 at 16:40, Kevin Wolf <kwolf@redhat.com> wrote:
> The following changes since commit ff79d5e939c38677a575e3493eb9b4d36eb21865:
>
>   Merge remote-tracking branch 'remotes/xtensa/tags/20170306-xtensa' into staging (2017-03-07 09:57:14 +0000)
>
> are available in the git repository at:
>
>
>   git://repo.or.cz/qemu/kevin.git tags/for-upstream
>
> for you to fetch changes up to b69f00dde490e88d55f5ee731545e690b2dc61f8:
>
>   commit: Don't use error_abort in commit_start (2017-03-07 14:53:29 +0100)
>
> ----------------------------------------------------------------
> Block layer fixes for 2.9.0-rc0
>

Applied, thanks.

-- PMM
