Received: from eggs.gnu.org ([2001:4830:134:3::10]:50020)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1cF0fv-00077o-1C
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 10:32:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1cF0fr-0000a2-RE
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 10:31:59 -0500
Received: from smtp.mail.uni-mannheim.de ([134.155.96.80]:48237)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sw@weilnetz.de>) id 1cF0fr-0000Zm-Kg
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 10:31:55 -0500
References: <cover.1479381090.git.vpalatin@chromium.org>
	<f228cb95-de64-5dc3-f761-390f20675541@linux.intel.com>
From: Stefan Weil <sw@weilnetz.de>
Message-ID: <d308380f-e6bd-10b5-d89b-3cc9e64d41ba@weilnetz.de>
Date: Thu, 8 Dec 2016 16:31:58 +0100
MIME-Version: 1.0
In-Reply-To: <f228cb95-de64-5dc3-f761-390f20675541@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 0/3] Add HAX support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yu Ning <yu.ning@linux.intel.com>, Vincent Palatin <vpalatin@chromium.org>, qemu-devel <qemu-devel@nongnu.org>

Am 08.12.2016 um 10:34 schrieb Yu Ning:
> As a HAXM developer at Intel, I just want to come out and show our
> support for Vincent's upstreaming effort. We'd love to see HAXM support
> code land in upstream QEMU, and will do what is necessary to make that
> happen.
> 
> We've been working on the issues that Vincent raised and have made some
> progress - see below.
> 
> Regards,
> Yu

Thanks a lot - I think that HAXM integration will make fast progress then.

AFAIK, there remain at least two other features which need to be addressed:

* support for real mode (e. g. BIOS code)

* support for macOS

Stefan
