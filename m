Received: from eggs.gnu.org ([2001:4830:134:3::10]:47359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eHrIZ-0000uI-Sd
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 08:12:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eHrIU-0004nz-3u
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 08:12:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60118)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1eHrIT-0004nM-U7
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 08:12:06 -0500
Date: Thu, 23 Nov 2017 21:11:58 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20171123131158.GF1624@lemon>
References: <151139029455.579.15894197976245791702@bafd83ae6430>
	<6b552301-3e07-f41d-fe8f-0e3de4fb9f13@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b552301-3e07-f41d-fe8f-0e3de4fb9f13@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v3 0/7] s390x/pci: Improve zPCI to cover
 more cases
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: qemu-devel@nongnu.org, pmorel@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, cohuck@redhat.com, zyimin@linux.vnet.ibm.com, agraf@suse.de, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Jeff Cody <jcody@redhat.com>

On Thu, 11/23 11:06, Christian Borntraeger wrote:
> Fam,
> 
> can you disable the iotest in patchew until the block thing is solved? It will create a lot of unrelated
> "false positives" that make it hard to detect real issues.

Done.
