Received: from eggs.gnu.org ([2001:4830:134:3::10]:46710)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1eM6nj-0000ho-Ff
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 01:33:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1eM6ng-00043s-Bl
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 01:33:55 -0500
Received: from mga14.intel.com ([192.55.52.115]:24816)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1eM6ng-00041y-1B
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 01:33:52 -0500
Date: Tue, 5 Dec 2017 14:33:13 +0800
From: Yang Zhong <yang.zhong@intel.com>
Message-ID: <20171205063313.GB4102@yangzhon-Virtual>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] About the light VM solution!
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, stefanha@redhat.com, berrange@redhat.com
Cc: qemu-devel@nongnu.org

Hello all,

As you know, AWS has decided to switch to KVM in their clouds. This news make almost all
china CSPs(clouds service provider) pay more attention on KVM/Qemu, especially light VM
solution.

Below are intel solution for light VM, qemu-lite.
http://events.linuxfoundation.org/sites/events/files/slides/Light%20weight%20virtualization%20with%20QEMU%26KVM_0.pdf

My question is whether community has some plan to implement light VM or alternative solutions? If no, whether our 
qemu-lite solution is suitable for upstream again? Many thanks!

Regards,

Yang
