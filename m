Received: from eggs.gnu.org ([2001:4830:134:3::10]:41689)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gKSh8-0007DV-LR
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 13:36:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gKSh5-0006uW-VY
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 13:36:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38732)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gKSh5-0006iW-Nw
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 13:36:47 -0500
Date: Wed, 7 Nov 2018 16:36:31 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181107183631.GA12503@habkost.net>
References: <1541488407-17045-1-git-send-email-jingqi.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1541488407-17045-1-git-send-email-jingqi.liu@intel.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/2] x86/cpu: Enable direct stores cpu
 features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Liu Jingqi <jingqi.liu@intel.com>
Cc: pbonzini@redhat.com, rth@twiddle.net, qemu-devel@nongnu.org, tao3.xu@intel.com

On Tue, Nov 06, 2018 at 03:13:25PM +0800, Liu Jingqi wrote:
> Enable direct stores cpu features including MOVDIRI and MOVDIR64B.
> 
> MOVDIRI moves doubleword or quadword from register to memory through
> direct store.
> MOVDIR64B moves 64-bytes as direct-store with 64-bytes write atomicity.

Queueing for 3.2, thanks.

-- 
Eduardo
