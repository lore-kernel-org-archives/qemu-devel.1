Received: from eggs.gnu.org ([2001:4830:134:3::10]:55036)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cUFXR-0005sV-Sr
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 11:26:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cUFXR-0000uD-AD
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 11:26:13 -0500
Received: from mail-io0-x22d.google.com ([2607:f8b0:4001:c06::22d]:34595)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cUFXR-0000th-56
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 11:26:13 -0500
Received: by mail-io0-x22d.google.com with SMTP id l66so41567921ioi.1
	for <qemu-devel@nongnu.org>; Thu, 19 Jan 2017 08:26:11 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAAKRE70s=Cdk9xedS3xavOj9_TMRa4ZNvZqVw8jqVxVMDCM7Vg@mail.gmail.com>
References: <CAAKRE72RN=DvVqxYMba5KdnWQ+jrAXTpxQc7Qdgiymu6oByosg@mail.gmail.com>
	<20170118102942.GA5284@stefanha-x1.localdomain>
	<CAAKRE70s=Cdk9xedS3xavOj9_TMRa4ZNvZqVw8jqVxVMDCM7Vg@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 19 Jan 2017 16:26:08 +0000
Message-ID: <CAJSP0QUU3CgJdX6p-vAQAyAeQio3Br7grUFBRrT-N0s2F6X58g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] VM Hung issue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Umar Draz <unix.co@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>

On Wed, Jan 18, 2017 at 10:46 AM, Umar Draz <unix.co@gmail.com> wrote:
> Well yes, whenever vm hung, then there is nothing on vnc display, and
> network of that vm is also down. I can not ping the vm that time.

Are you saying the VNC client connects successfully to a hung VM but
the display is blank?

Stefan
