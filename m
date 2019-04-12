Received: from eggs.gnu.org ([209.51.188.92]:47464)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hF1BZ-00069O-5H
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 14:46:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hF1BY-0002ij-Au
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 14:46:01 -0400
Date: Fri, 12 Apr 2019 15:45:49 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190412184549.GB31999@habkost.net>
References: <20190411102025.22559-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190411102025.22559-1-cohuck@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-4.1] hw: add compat machines for 4.1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, David Gibson <david@gibson.dropbear.id.au>, David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-arm@nongnu.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org

On Thu, Apr 11, 2019 at 12:20:25PM +0200, Cornelia Huck wrote:
> Add 4.1 machine types for arm/i440fx/q35/s390x/spapr.
> 
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>

Thanks!

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

I'm queueing it on machine-next.

-- 
Eduardo
