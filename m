Received: from eggs.gnu.org ([2001:4830:134:3::10]:50356)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dJ0zK-0000bF-3i
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 13:12:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dJ0zG-0000Px-ME
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 13:12:50 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:34977)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dJ0zG-0000PJ-Bp
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 13:12:46 -0400
Received: by mail-wr0-x241.google.com with SMTP id g76so4395239wrd.2
	for <qemu-devel@nongnu.org>; Thu, 08 Jun 2017 10:12:46 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
References: <da068337-4167-aa53-3a42-bdc61a0a6907@redhat.com>
Message-ID: <5055fed4-71b6-6634-3214-62aa0734401a@redhat.com>
Date: Thu, 8 Jun 2017 19:12:42 +0200
MIME-Version: 1.0
In-Reply-To: <da068337-4167-aa53-3a42-bdc61a0a6907@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] Reminder: CFP: KVM Forum 2017
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>, "seabios@seabios.org" <seabios@seabios.org>, "libvir-list@redhat.com" <libvir-list@redhat.com>

Just a quick reminder that the CFP is going to close in a week.

Paolo

On 02/05/2017 12:42, Paolo Bonzini wrote:
> ================================================================
> KVM Forum 2017: Call For Participation
> October 25-27, 2017 - Hilton Prague - Prague, Czech Republic
> 
> (All submissions must be received before midnight June 15, 2017)
> =================================================================
> 
> KVM Forum is an annual event that presents a rare opportunity
> for developers and users to meet, discuss the state of Linux
> virtualization technology, and plan for the challenges ahead. 
> We invite you to lead part of the discussion by submitting a speaking
> proposal for KVM Forum 2017.
> 
> At this highly technical conference, developers driving innovation
> in the KVM virtualization stack (Linux, KVM, QEMU, libvirt) can
> meet users who depend on KVM as part of their offerings, or to
> power their data centers and clouds.
> 
> KVM Forum will include sessions on the state of the KVM
> virtualization stack, planning for the future, and many
> opportunities for attendees to collaborate. As we celebrate ten years
> of KVM development in the Linux kernel, KVM continues to be a
> critical part of the FOSS cloud infrastructure.
> 
> This year, KVM Forum is joining Open Source Summit in Prague, 
> Czech Republic. Selected talks from KVM Forum will be presented on
> Wednesday October 25 to the full audience of the Open Source Summit.
> Also, attendees of KVM Forum will have access to all of the talks from
> Open Source Summit on Wednesday.
> 
> http://events.linuxfoundation.org/cfp
> 
> Suggested topics:
> * Scaling, latency optimizations, performance tuning, real-time guests
> * Hardening and security
> * New features
> * Testing
> 
> KVM and the Linux kernel:
> * Nested virtualization
> * Resource management (CPU, I/O, memory) and scheduling
> * VFIO: IOMMU, SR-IOV, virtual GPU, etc.
> * Networking: Open vSwitch, XDP, etc.
> * virtio and vhost
> * Architecture ports and new processor features
> 
> QEMU:
> * Management interfaces: QOM and QMP
> * New devices, new boards, new architectures
> * Graphics, desktop virtualization and virtual GPU
> * New storage features
> * High availability, live migration and fault tolerance
> * Emulation and TCG
> * Firmware: ACPI, UEFI, coreboot, U-Boot, etc.
> 
> Management and infrastructure
> * Managing KVM: Libvirt, OpenStack, oVirt, etc.
> * Storage: Ceph, Gluster, SPDK, etc.r
> * Network Function Virtualization: DPDK, OPNFV, OVN, etc.
> * Provisioning
> 
> 
> ===============
> SUBMITTING YOUR PROPOSAL
> ===============
> Abstracts due: June 15, 2017
> 
> Please submit a short abstract (~150 words) describing your presentation
> proposal. Slots vary in length up to 45 minutes. Also include the proposal
> type -- one of:
> - technical talk
> - end-user talk
> 
> Submit your proposal here:
> http://events.linuxfoundation.org/cfp
> Please only use the categories "presentation" and "panel discussion"
> 
> You will receive a notification whether or not your presentation proposal
> was accepted by August 10, 2017.
> 
> Speakers will receive a complimentary pass for the event. In the instance
> that case your submission has multiple presenters, only the primary speaker for a
> proposal will receive a complimentary event pass. For panel discussions, all
> panelists will receive a complimentary event pass.
> 
> TECHNICAL TALKS
> 
> A good technical talk should not just report on what has happened over
> the last year; it should present a concrete problem and how it impacts
> the user and/or developer community. Whenever applicable, focus on
> work that needs to be done, difficulties that haven't yet been solved,
> and on decisions that other developers should be aware of. Summarizing
> recent developments is okay but it should not be more than a small
> portion of the overall talk.
> 
> END-USER TALKS
> 
> One of the big challenges as developers is to know what, where and how
> people actually use our software. We will reserve a few slots for end
> users talking about their deployment challenges and achievements.
> 
> If you are using KVM in production you are encouraged submit a speaking
> proposal. Simply mark it as an end-user talk. As an end user, this is a
> unique opportunity to get your input to developers.
> 
> HANDS-ON / BOF SESSIONS
> 
> We will reserve some time for people to get together and discuss
> strategic decisions as well as other topics that are best solved within
> smaller groups.
> 
> These sessions will be announced during the event. If you are interested
> in organizing such a session, please add it to the list at
> 
>   http://www.linux-kvm.org/page/KVM_Forum_2017_BOF
> 
> Let people you think who might be interested know about your BOF, and encourage
> them to add their names to the wiki page as well. Please try to
> add your ideas to the list before KVM Forum starts.
> 
> 
> PANEL DISCUSSIONS
> 
> If you are proposing a panel discussion, please make sure that you list
> all of your potential panelists in your the abstract. We will request full
> biographies if a panel is accepted.
> 
> 
> ===============
> HOTEL / TRAVEL
> ===============
> 
> This year's event will take place at the Hilton Prague.
> For information on discounted room rates for conference attendees
> and on other hotels close to the conference, please visit
> http://events.linuxfoundation.org/events/kvm-forum/attend/hotel-travel.
> 
> ===============
> IMPORTANT DATES
> ===============
> Submission deadline: June 15, 2017
> Notification: August 10, 2017
> Schedule announced: August 17, 2017
> Event dates: October 25-27, 2017
> 
> Thank you for your interest in KVM. We're looking forward to your
> submissions and seeing you at the KVM Forum 2017 in October!
> 
> -your KVM Forum 2017 Program Committee
> 
> Please contact us with any questions or comments at
> kvm-forum-2017-pc@redhat.com
> 
