Received: from eggs.gnu.org ([2001:4830:134:3::10]:37959)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cbl67-00084I-Rr
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 04:33:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cbl67-0004VH-4m
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 04:33:03 -0500
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20170120162527.66075-1-farman@linux.vnet.ibm.com>
	<ebca91ef-52f0-2f2c-d52f-d95569ec73e2@redhat.com>
	<7c45fcaf-56dc-097b-14b0-ac497fd1ab6b@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <cf2de598-c157-375c-63ac-413a17bb0cf2@redhat.com>
Date: Thu, 9 Feb 2017 10:32:55 +0100
MIME-Version: 1.0
In-Reply-To: <7c45fcaf-56dc-097b-14b0-ac497fd1ab6b@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 0/3] scsi-generic and BLKSECTGET
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, Eric Farman <farman@linux.vnet.ibm.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org



On 08/02/2017 23:33, Max Reitz wrote:
> Noticed now that Paolo has already merged this. Well, then out it goes.
> Too bad the swap of BDRV_REQUEST_MAX_BYTES and BDRV_REQUEST_MAX_SECTORS
> is not in his tree.
> 
> Well, I'll make it an own patch then.

Sorry, that was by mistake. :(

Paolo
