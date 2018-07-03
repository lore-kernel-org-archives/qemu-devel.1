Received: from eggs.gnu.org ([2001:4830:134:3::10]:58499)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1faN6z-0000SY-3Q
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 11:21:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1faN6v-0002gJ-4w
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 11:21:01 -0400
References: <20180618215601.8974-1-mail@sebastianbauer.info>
	<20180618235557.GB25461@umbus.fritz.box>
	<73dd5b26b622e6c59776976aa2c7a3a0@sebastianbauer.info>
	<20180619043631.GC11674@umbus.fritz.box>
	<607559ef0fd95f557b5001a5db29883f@sebastianbauer.info>
	<20180630061443.GP3422@umbus.fritz.box>
	<alpine.BSF.2.21.1806301325320.13465@zero.eik.bme.hu>
	<20180702040239.GS3422@umbus.fritz.box>
	<20180702052202.GY3422@umbus.fritz.box>
	<2fdb7495b7979040f40a361d78d35d85@sebastianbauer.info>
	<20180703044136.GN3422@umbus.fritz.box>
From: Eric Blake <eblake@redhat.com>
Message-ID: <dbac814a-62bd-d46a-8d7c-b070cc307c87@redhat.com>
Date: Tue, 3 Jul 2018 10:20:41 -0500
MIME-Version: 1.0
In-Reply-To: <20180703044136.GN3422@umbus.fritz.box>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] ppc: Include vga cirrus card into the
 compiling process
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, Sebastian Bauer <mail@sebastianbauer.info>
Cc: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org, thuth@redhat.com, qemu-ppc@nongnu.org

On 07/02/2018 11:41 PM, David Gibson wrote:

> That's a good point.  At the moment there's really nothing there about
> testing your patch before submission, which is a bit of an ommission.
> 
> [1] covers a bunch of ways that qemu can be tested, but doesn't give
> much idea about priority.
> 
> +eblake, you seem to have made more mods than anyone else to the
> SubmitAPatch wiki page.  What do you think about adding a subsection
> about what basic testing you should do before posting a patch?

No good deed goes unpunished :)

I've added https://wiki.qemu.org/Contribute/SubmitAPatch#Test_your_patches

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
