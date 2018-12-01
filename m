Received: from eggs.gnu.org ([2001:4830:134:3::10]:43875)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gT3mJ-0004Ki-QN
	for qemu-devel@nongnu.org; Sat, 01 Dec 2018 06:49:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gT3mI-0001W0-Ea
	for qemu-devel@nongnu.org; Sat, 01 Dec 2018 06:49:43 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:43258)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gT3mI-0001VZ-9w
	for qemu-devel@nongnu.org; Sat, 01 Dec 2018 06:49:42 -0500
Received: by mail-oi1-x242.google.com with SMTP id u18so7050123oie.10
	for <qemu-devel@nongnu.org>; Sat, 01 Dec 2018 03:49:42 -0800 (PST)
MIME-Version: 1.0
References: <154362272919.7153.15101701755308287523.stgit@gimli.home>
	<154362328267.7153.14787469935288240705.stgit@gimli.home>
In-Reply-To: <154362328267.7153.14787469935288240705.stgit@gimli.home>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 1 Dec 2018 11:49:30 +0000
Message-ID: <CAFEAcA-YWkkBgz4yyiBsRN2Z-4BAZBUGoWNNFKGG_xqUxirXhA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [for-3.2 PATCH 8/9] q35/440fx/arm/spapr: Add QEMU
 3.2 machine type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

On Sat, 1 Dec 2018 at 00:14, Alex Williamson <alex.williamson@redhat.com> wrote:
>
> Including all machine types that might have a pcie-root-port.

The next release will be 4.0, not 3.2. Our new
version numbering system rolls the major version
number for the first release of every calendar year.

thanks
-- PMM
