Received: from eggs.gnu.org ([209.51.188.92]:37731)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hMeMM-0007pd-5a
	for qemu-devel@nongnu.org; Fri, 03 May 2019 16:00:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hMeMK-0004w9-8L
	for qemu-devel@nongnu.org; Fri, 03 May 2019 16:00:42 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46735)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hMeMK-0004q1-3u
	for qemu-devel@nongnu.org; Fri, 03 May 2019 16:00:40 -0400
Received: by mail-qt1-f195.google.com with SMTP id i31so8108214qti.13
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 13:00:36 -0700 (PDT)
Date: Fri, 3 May 2019 16:00:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190503155951-mutt-send-email-mst@kernel.org>
References: <20181220054037.24320-1-peterx@redhat.com>
	<20181220054037.24320-2-peterx@redhat.com>
	<20190426132744.2b594bf5@x1.home> <20190426150236.1af2ff08@x1.home>
	<94415012.15677076.1556342950794.JavaMail.zimbra@redhat.com>
	<daded638-42f1-9bc3-8c36-66b0fbba9438@redhat.com>
	<20190429082106.4fd59e77@x1.home>
	<20190429145556.GA28722@habkost.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190429145556.GA28722@habkost.net>
Subject: Re: [Qemu-devel] [PATCH v2 1/3] q35: set split kernel irqchip as
 default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>

On Mon, Apr 29, 2019 at 11:55:56AM -0300, Eduardo Habkost wrote:
> irqchip=split and irqchip=kernel aren't guest ABI compatible, are
> they?

Can you remind me why they aren't?

> -- 
> Eduardo
