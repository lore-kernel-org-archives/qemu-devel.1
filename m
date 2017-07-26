Received: from eggs.gnu.org ([2001:4830:134:3::10]:46343)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1daKbk-0002PY-3t
	for Qemu-devel@nongnu.org; Wed, 26 Jul 2017 07:36:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1daKbj-0001Yv-7T
	for Qemu-devel@nongnu.org; Wed, 26 Jul 2017 07:36:04 -0400
Received: from mail-wr0-x22b.google.com ([2a00:1450:400c:c0c::22b]:34620)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1daKbi-0001YL-Vg
	for Qemu-devel@nongnu.org; Wed, 26 Jul 2017 07:36:03 -0400
Received: by mail-wr0-x22b.google.com with SMTP id 12so130569484wrb.1
	for <Qemu-devel@nongnu.org>; Wed, 26 Jul 2017 04:36:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <cc3f3aa6-155f-a50d-f89c-54effaaa69cc@redhat.com>
References: <f3b1276a-92e3-54f3-c6a0-5f8e16124014@redhat.com>
	<507e7a29-5461-e152-123e-aab9dfc1f8ac@redhat.com>
	<cc3f3aa6-155f-a50d-f89c-54effaaa69cc@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 26 Jul 2017 12:35:41 +0100
Message-ID: <CAFEAcA_MC1r4+qTsUief7zxz0a9qsM+2jO_SudydqCjzT6pkew@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] RFC: unified --help information
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Qemu-devel@nongnu.org" <Qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu block <qemu-block@nongnu.org>

On 26 July 2017 at 12:22, Eric Blake <eblake@redhat.com> wrote:
> So something like these two lines (via a macro) in all of the
> executables, ideally at the tail end of --help output?
>
> See <https://qemu.org/contribute/report-a-bug> for bug reports.
> More information on the qemu project at <https://qemu.org>

Text looks good to me. A minor nit: better not use https://
URLs til we fix the website (which currently makes firefox
warn about an invalid security certificate...)

Would be good to put this in GUI about dialog boxes
and the like too.

thanks
-- PMM
