Received: from eggs.gnu.org ([2001:4830:134:3::10]:32834)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gYtEa-0006kq-Vo
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 08:47:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gYtEW-00005V-VT
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 08:47:00 -0500
References: <20181212091623.16950-1-david@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <281239fb-0d3e-c628-20f5-559b8fab3b32@redhat.com>
Date: Mon, 17 Dec 2018 14:46:45 +0100
MIME-Version: 1.0
In-Reply-To: <20181212091623.16950-1-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 00/11] pci: hotplug handler reworks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>, Collin Walling <walling@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, Pierre Morel <pmorel@linux.ibm.com>, qemu-ppc@nongnu.org

On 12.12.18 10:16, David Hildenbrand wrote:
> This is a resend with added RB's.  @MST please pick up :)

Friendly ping, I want to continue working on the stuff that builds up on
top of this.


-- 

Thanks,

David / dhildenb
