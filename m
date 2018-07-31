Received: from eggs.gnu.org ([2001:4830:134:3::10]:60910)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fkSCT-0008Cg-QQ
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 06:48:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fkSCO-0007oh-Rm
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 06:48:21 -0400
Date: Tue, 31 Jul 2018 12:48:09 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180731124809.0502bcb9.cohuck@redhat.com>
In-Reply-To: <20180731085205.2637da26.cohuck@redhat.com>
References: <1532959766-53343-1-git-send-email-borntraeger@de.ibm.com>
	<b7bf6a3f-812f-78af-4f5f-832eb460fbf1@de.ibm.com>
	<153296989359.10934.14853590010864246630@sif>
	<20180731085205.2637da26.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/1] s390x/sclp: fix maxram calculation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Richard Henderson <rth@twiddle.net>, Janosch Frank <frankja@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, imbrenda@linux.vnet.ibm.com, qemu-stable@nongnu.org

On Tue, 31 Jul 2018 08:52:05 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> On Mon, 30 Jul 2018 11:58:13 -0500
> Michael Roth <mdroth@linux.vnet.ibm.com> wrote:
> 
> > Quoting Christian Borntraeger (2018-07-30 10:31:12)  
> > > Are we still able to get things into 2.12.1 or are we too late?    
> > 
> > Freeze is EOD today, but I can grab them if they hit master/rc3 tomorrow.  
> 
> OK, I just sent a pull request with this patch.

...and it is in master now.
