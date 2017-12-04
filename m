Received: from eggs.gnu.org ([2001:4830:134:3::10]:53719)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eLsZS-0003DR-0C
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 10:22:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eLsZN-0006es-Qm
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 10:22:13 -0500
Received: from mail-ot0-x229.google.com ([2607:f8b0:4003:c0f::229]:34356)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eLsZN-0006eZ-KV
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 10:22:09 -0500
Received: by mail-ot0-x229.google.com with SMTP id o23so15012694otd.1
	for <qemu-devel@nongnu.org>; Mon, 04 Dec 2017 07:22:09 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171204151705.26028-1-samuel.thibault@ens-lyon.org>
References: <20171204151705.26028-1-samuel.thibault@ens-lyon.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 Dec 2017 15:21:48 +0000
Message-ID: <CAFEAcA9CYSCJtGjRPQonyA8jvMZ6VBaWbGtrnJ7y6mJEbERMHg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/1] baum braille device update
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 4 December 2017 at 15:17, Samuel Thibault
<samuel.thibault@ens-lyon.org> wrote:
> warning: redirection vers https://people.debian.org/~sthibault/qemu.git/
> The following changes since commit 7edaf99759017d3e175e37cffc3536e86a3bd380:
>
>   Merge remote-tracking branch 'remotes/thibault/tags/samuel-thibault' into staging (2017-11-13 13:54:59 +0000)
>
> are available in the Git repository at:
>
>   http://people.debian.org/~sthibault/qemu.git tags/samuel-thibault
>
> for you to fetch changes up to 15405525fce773d43e7e5cabc2b9ac4b9d4d7672:
>
>   baum: Truncate braille device size to 84x1 (2017-12-03 19:35:50 +0100)
>
> ----------------------------------------------------------------
> baum updates
>
> ----------------------------------------------------------------
> Samuel Thibault (1):
>       baum: Truncate braille device size to 84x1

Hi. Is this pull request intended for 2.11? We're currently
in freeze for that and only taking "absolutely release critical"
bug fixes...

thanks
-- PMM
