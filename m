Received: from eggs.gnu.org ([2001:4830:134:3::10]:46200)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dihVn-00014y-Fv
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 09:40:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dihVk-0008L8-Df
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 09:40:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33890)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dihVk-0008Cz-6j
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 09:40:28 -0400
Date: Fri, 18 Aug 2017 15:40:11 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170818154011.52499f8c.cohuck@redhat.com>
In-Reply-To: <20170817111116.79e918e9.cohuck@redhat.com>
References: <1502951113-4246-1-git-send-email-thuth@redhat.com>
	<20170817111116.79e918e9.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.11 0/6] Enable more qtests for s390x
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <david@redhat.com>, Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Eric Farman <farman@linux.vnet.ibm.com>, Fan Zhang <zhangfan@linux.vnet.ibm.com>, Farhan Ali <alifm@linux.vnet.ibm.com>, Fei Li <sherrylf@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>, Jason J Herne <jjherne@linux.vnet.ibm.com>, Jing Liu <liujbjl@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, QingFeng Hao <haoqf@linux.vnet.ibm.com>, Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>, Yang Chen <bjcyang@linux.vnet.ibm.com>, Yi Min Zhao <zyimin@linux.vnet.ibm.com>, Marc Mari <markmb@redhat.com>, Cleber Rosa <crosa@redhat.com>, Michael S Tsirkin <mst@redhat.com>

On Thu, 17 Aug 2017 11:11:16 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> On Thu, 17 Aug 2017 08:25:07 +0200
> Thomas Huth <thuth@redhat.com> wrote:

> > Thomas Huth (6):
> >   tests: Run filter-redirector and -mirror test only on POSIX systems
> >   tests: Add network filter tests to the check-qtest-s390x list  
> 
> I think these two are fine as-is.

(...)

> The big question remains again: Who merges this? I can merge this
> through the s390x tree if there are no other takers.

I just took the liberty to queue these two to s390-next.
