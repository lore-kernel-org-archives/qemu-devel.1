Received: from eggs.gnu.org ([2001:4830:134:3::10]:37000)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eqjV0-0003wH-O4
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 12:57:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eqjUz-00065N-N0
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 12:57:10 -0500
Received: from mail-oi0-x233.google.com ([2607:f8b0:4003:c06::233]:43879)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eqjUz-000656-HC
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 12:57:09 -0500
Received: by mail-oi0-x233.google.com with SMTP id a207so13518461oii.10
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 09:57:09 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1519641757-12396-1-git-send-email-thuth@redhat.com>
References: <1519641757-12396-1-git-send-email-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Feb 2018 17:56:48 +0000
Message-ID: <CAFEAcA8JQKZ10=EOTWPfLcwrTHnRDiT6KihBM717VNGcoHARww@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL-for-s390x 00/14] s390-ccw firmware update
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x <qemu-s390x@nongnu.org>, "Collin L. Walling" <walling@linux.vnet.ibm.com>, QEMU Developers <qemu-devel@nongnu.org>

On 26 February 2018 at 10:42, Thomas Huth <thuth@redhat.com> wrote:
>
>  Hi Cornelia!
>
> The following changes since commit 0a773d55ac76c5aa89ed9187a3bc5af8c5c2a6d0:
>
>   maintainers: Add myself as a OpenBSD maintainer (2018-02-23 12:05:07 +0000)
>
> are available in the git repository at:
>
>   https://github.com/huth/qemu.git tags/s390-ccw-bios-2018-02-26
>
> for you to fetch changes up to 9c050f3d15697c4c84c9d6aa7af779a273b71d87:
>
>   pc-bios/s390: Rebuild the s390x firmware images with the boot menu changes (2018-02-26 11:10:30 +0100)
>
> ----------------------------------------------------------------
> Boot menu patches by Collin L. Walling
> ----------------------------------------------------------------

I thought we'd agreed on 'PULL SUBSYSTEM whatever' rather than
'PULL-for-whatever' ?  I guess it doesn't matter much what
convention we use but we should have one... My guess is that
gmail's less-than-fantastic filtering functionality is going
to be happier with a separate-words-phrase like 'PULL SUBSYSTEM'
than a prefix-of-a-word like 'pull-for-', though.

thanks
-- PMM
