Received: from eggs.gnu.org ([2001:4830:134:3::10]:39083)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gRdOk-0005nZ-Ag
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 08:27:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gRdFV-0007hy-V6
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 08:18:01 -0500
References: <20181127114102.4319-1-david@redhat.com>
	<20181127133819.52621d1c.cohuck@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <2df11a2f-640f-f3dc-27d7-b7e190ad0b87@redhat.com>
Date: Tue, 27 Nov 2018 14:17:54 +0100
MIME-Version: 1.0
In-Reply-To: <20181127133819.52621d1c.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1] s390x/tod: properly stop the KVM TOD
 while the guest is not running
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Richard Henderson <rth@twiddle.net>


> This one is a bit late for 3.1, but should it be cc:stable?
> 

Missed this question. Good point, not sure if this is worth cc:stable.

-- 

Thanks,

David / dhildenb
