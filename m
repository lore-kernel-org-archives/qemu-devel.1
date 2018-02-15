Received: from eggs.gnu.org ([2001:4830:134:3::10]:38399)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1emOV9-0003vf-B2
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 13:43:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1emOV8-00026d-Kt
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 13:43:23 -0500
References: <20180126144742.3636-1-lvivier@redhat.com>
	<1ad5086b-1704-0561-2d29-147d3d2ee6d3@ilande.co.uk>
	<3bb55aca-77fa-9ab7-4b13-98698d3c0008@redhat.com>
	<9f0f9819-f608-c326-f975-a3338d6fc24d@redhat.com>
	<65da244c-1550-0292-a849-10c0dc1f35b0@ilande.co.uk>
	<20180214045833.GB5247@umbus.fritz.box>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <a47d9769-0a0f-4aff-21d9-ca68025a1d55@ilande.co.uk>
Date: Thu, 15 Feb 2018 18:42:56 +0000
MIME-Version: 1.0
In-Reply-To: <20180214045833.GB5247@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3] hw/char: remove legacy interface
 escc_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Laurent Vivier <lvivier@redhat.com>, Alexander Graf <agraf@suse.de>, qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>

On 14/02/18 04:58, David Gibson wrote:

>> David, would you be willing to take this via ppc-for-2.12 since it covers
>> the ESCC used in the PPC Mac machines?
> 
> Short term: Yes, I can stage this.  I've lost track of this thread
> though.  Laurent, can you please resend with the various R-bs collated
> together.
> 
> Long term: I've been thinking for a while that I'm not greatly
> qualified to review or test patches for the Macintosh platforms.  And
> I've also been thinking for a while that you (Mark) seem the obvious
> choice to be sub-maintainer for the ppc based Macintosh machine types
> and related device models.  Would you be willing to take that on?

Sure, I'm happy to do that. Not that I know a great deal about PPC Macs, 
but I've got a good set of test images that get booted regularly when 
testing OpenBIOS, so it's fairly easy for me to pick up regressions.


ATB,

Mark.
