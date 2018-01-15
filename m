Received: from eggs.gnu.org ([2001:4830:134:3::10]:33333)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1eb9WK-0004Nd-SS
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 13:30:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1eb9WF-0005UT-V6
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 13:30:08 -0500
Received: from chuckie.co.uk ([82.165.15.123]:45346
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1eb9WF-0005TA-Ol
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 13:30:03 -0500
References: <20180114104751.21965-1-mark.cave-ayland@ilande.co.uk>
	<20180114104751.21965-10-mark.cave-ayland@ilande.co.uk>
	<e4cb0bba-c6e0-0a38-7224-71738c3a7d5a@amsat.org>
	<b0a9500a-6aae-2d2d-6a5e-0307e32fa23f@zoho.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <fbf0ce41-2346-d391-5e16-d560279a9b15@ilande.co.uk>
Date: Mon, 15 Jan 2018 18:29:55 +0000
MIME-Version: 1.0
In-Reply-To: <b0a9500a-6aae-2d2d-6a5e-0307e32fa23f@zoho.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 09/11] pci: add trace-events support for
 hw/pci-host
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: marcel@redhat.com, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, atar4qemu@gmail.com
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>

On 14/01/18 16:27, Marcel Apfelbaum wrote:

> On 14/01/2018 15:32, Philippe Mathieu-Daudé wrote:
>> On 01/14/2018 07:47 AM, Mark Cave-Ayland wrote:
>>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> Not sure this is worth a separate commit (I'd squash it in the next
>> patch), still:
> 
> I agree, no need to add a new directory to the trace list
> while we don't have a trace events file.

Hi Marcel,

The basic skeleton of the file is there with the just the default 
comments, but other than that it's empty. The only reason I placed it 
into a separate patch was so it could get an Ack from someone on the PCI 
side, but I'm happy to squash it based upon your comment above.


ATB,

Mark.
