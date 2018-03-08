Received: from eggs.gnu.org ([2001:4830:134:3::10]:55220)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1eu0jG-0003fA-AS
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 13:57:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1eu0jC-00080N-E4
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 13:57:26 -0500
Received: from chuckie.co.uk ([82.165.15.123]:47559
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1eu0jC-0007zn-72
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 13:57:22 -0500
References: <1520415568-19070-1-git-send-email-thuth@redhat.com>
	<c902a158-1d19-d271-ea49-f5a2f72347bd@ilande.co.uk>
	<2aa2df96-b1c3-deef-9fbf-a2560f58d17d@redhat.com>
	<fe05591f-9f16-228c-7d8c-65eb04a941ab@redhat.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <46945588-134b-4f93-0ba5-ce118c84acce@ilande.co.uk>
Date: Thu, 8 Mar 2018 18:57:10 +0000
MIME-Version: 1.0
In-Reply-To: <fe05591f-9f16-228c-7d8c-65eb04a941ab@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hw/sparc/sun4m: Fix implicit creation of
 "-drive if=scsi" devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Artyom Tarasenko <atar4qemu@gmail.com>

On 08/03/18 18:51, Paolo Bonzini wrote:

> On 08/03/2018 05:33, Thomas Huth wrote:
>> Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> 
> Queued, thanks.

Hi Paolo,

I quickly added this to my pull request this morning for the leon3 MMU 
patch, so it has already been applied.


ATB,

Mark.
