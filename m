Received: from eggs.gnu.org ([2001:4830:134:3::10]:48093)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fdCRf-0004oL-8t
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 06:34:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fdCRa-0005I8-E2
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 06:34:03 -0400
References: <1530811543-6881-1-git-send-email-jjherne@linux.ibm.com>
	<1530811543-6881-2-git-send-email-jjherne@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <998a5201-3fa0-2f60-ff89-ebe1161fed4b@redhat.com>
Date: Wed, 11 Jul 2018 12:33:54 +0200
MIME-Version: 1.0
In-Reply-To: <1530811543-6881-2-git-send-email-jjherne@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [RFC 01/15] s390 vfio-ccw: Add
 bootindex property and IPLB data
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Jason J. Herne" <jjherne@linux.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com, pasic@linux.ibm.com, bjsdjshi@linux.ibm.com, borntraeger@de.ibm.com

On 05.07.2018 19:25, Jason J. Herne wrote:
> From: "Jason J. Herne" <jjherne@linux.vnet.ibm.com>

You might want to do a --reset-author of this patch to get rid of this
"From:" line...

> Add bootindex property and iplb data for vfio-ccw devices. This allows us to
> forward boot information into the bios for vfio-ccw devices.
> 
> Signed-off-by: Jason J. Herne <jjherne@linux.vnet.ibm.com>

... and remove the superfluous S-o-b line, too?

> Acked-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>

 Thomas
