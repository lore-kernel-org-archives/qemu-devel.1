Received: from eggs.gnu.org ([2001:4830:134:3::10]:35875)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cjOkL-0007Mb-Sh
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 06:18:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cjOkK-0008FY-QM
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 06:18:09 -0500
Received: from mail-wr0-x231.google.com ([2a00:1450:400c:c0c::231]:36663)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cjOkK-0008FI-Kh
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 06:18:08 -0500
Received: by mail-wr0-x231.google.com with SMTP id u108so49598514wrb.3
	for <qemu-devel@nongnu.org>; Thu, 02 Mar 2017 03:18:08 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1488272804-27144-1-git-send-email-kraxel@redhat.com>
References: <1488272804-27144-1-git-send-email-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 2 Mar 2017 11:17:46 +0000
Message-ID: <CAFEAcA8ekZ0BxeXkH3mNcChZ7BCHGx=+Y+KEkMP9Jqh6iWfjdg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 0/1] seabios: update to 1.10.2 release
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, John Snow <jsnow@redhat.com>

On 28 February 2017 at 09:06, Gerd Hoffmann <kraxel@redhat.com> wrote:
>   Hi,
>
> Here comes the seabios update for qemu 2.9,
> the just tagged 1.10.2 release.
>
> Our seabios.git mirror @ qemu.org seems to not sync properly.  The
> commit isn't there even though it was pushed a few days ago already
> (only the tag was pushed today).  John, can you have a look please?
> master branch, *-stable branches and all tags should be mirrored.
>
> thanks,
>   Gerd
>
> The following changes since commit 9b9fbe8a4e9eec9072ee2697a6af59144442785f:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/pull-ui-20170227-1' into staging (2017-02-27 19:19:46 +0000)
>
> are available in the git repository at:
>
>
>   git://git.kraxel.org/qemu tags/pull-seabios-20170228-1
>
> for you to fetch changes up to 8779fccbef0c2e97fd6564ddf9f1df9fc724f2f0:
>
>   seabios: update to 1.10.2 release (2017-02-28 09:54:23 +0100)
>
> ----------------------------------------------------------------
> seabios: update to 1.10.2 release

Applied, thanks.

-- PMM
