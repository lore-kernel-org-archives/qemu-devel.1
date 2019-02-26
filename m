Received: from eggs.gnu.org ([209.51.188.92]:33123)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1gySoA-0000Gu-La
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 21:49:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1gySo9-0003x2-W0
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 21:49:26 -0500
Received: from mail-it1-x129.google.com ([2607:f8b0:4864:20::129]:38031)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1gySo9-0003wR-Nf
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 21:49:25 -0500
Received: by mail-it1-x129.google.com with SMTP id l66so1889720itg.3
	for <qemu-devel@nongnu.org>; Mon, 25 Feb 2019 18:49:25 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <20190225152618.r3epnypkpu6fyokt@sirius.home.kraxel.org>
Date: Mon, 25 Feb 2019 21:49:22 -0500
Content-Transfer-Encoding: 7bit
Message-Id: <A17B6D30-F428-48E5-B9D0-6F6E7DEE3778@gmail.com>
References: <CAKyx-3Paa6_RreGZw3sT+qmwu1=_DLnR_RDxa_gN20vwD1EnLw@mail.gmail.com>
	<20190225152618.r3epnypkpu6fyokt@sirius.home.kraxel.org>
Subject: Re: [Qemu-devel] Questions about EDID
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel qemu-devel <qemu-devel@nongnu.org>


> On Feb 25, 2019, at 10:26 AM, Gerd Hoffmann <kraxel@redhat.com> wrote:
> 
> On Mon, Feb 25, 2019 at 09:05:30AM -0500, G 3 wrote:
>> Hi Gerd, I was wondering if you have made any documentation for your EDID
>> patches. If you have could you provide a link please?
> 
> No docs.
> 
>> Also could a feature be added that allows the user to specify resolutions
>> to be made available to the guest?
>> 
>> Maybe it could work like this: -device VGA,edid=on,res=1366x768,7680x4320
> 
> A single resolution works (via xres + yres properties).

Could you send an example of the xres and yres properties please?
I tried this but it didn't work: -device VGA,edid=on,xres=999,yres=888

Thank you.
