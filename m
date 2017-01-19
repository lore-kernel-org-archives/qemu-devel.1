Received: from eggs.gnu.org ([2001:4830:134:3::10]:42478)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <unix.co@gmail.com>) id 1cUGQO-0006fB-TY
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 12:23:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <unix.co@gmail.com>) id 1cUGQO-0006Z1-2i
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 12:23:00 -0500
Received: from mail-yw0-x244.google.com ([2607:f8b0:4002:c05::244]:34508)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <unix.co@gmail.com>) id 1cUGQN-0006Xy-Sh
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 12:22:59 -0500
Received: by mail-yw0-x244.google.com with SMTP id v73so5207966ywg.1
	for <qemu-devel@nongnu.org>; Thu, 19 Jan 2017 09:22:58 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAJSP0QUU3CgJdX6p-vAQAyAeQio3Br7grUFBRrT-N0s2F6X58g@mail.gmail.com>
References: <CAAKRE72RN=DvVqxYMba5KdnWQ+jrAXTpxQc7Qdgiymu6oByosg@mail.gmail.com>
	<20170118102942.GA5284@stefanha-x1.localdomain>
	<CAAKRE70s=Cdk9xedS3xavOj9_TMRa4ZNvZqVw8jqVxVMDCM7Vg@mail.gmail.com>
	<CAJSP0QUU3CgJdX6p-vAQAyAeQio3Br7grUFBRrT-N0s2F6X58g@mail.gmail.com>
From: Umar Draz <unix.co@gmail.com>
Date: Thu, 19 Jan 2017 22:22:57 +0500
Message-ID: <CAAKRE72fjOwKs6V8MMOB-9WWv1vYidKYt3QSTZAoxEboXq2f5g@mail.gmail.com>
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
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>

Yes the display is blank, and network also not responding, it means vm
somewhere hung.

On Thu, Jan 19, 2017 at 9:26 PM, Stefan Hajnoczi <stefanha@gmail.com> wrote:

> On Wed, Jan 18, 2017 at 10:46 AM, Umar Draz <unix.co@gmail.com> wrote:
> > Well yes, whenever vm hung, then there is nothing on vnc display, and
> > network of that vm is also down. I can not ping the vm that time.
>
> Are you saying the VNC client connects successfully to a hung VM but
> the display is blank?
>
> Stefan
>
