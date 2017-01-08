Received: from eggs.gnu.org ([2001:4830:134:3::10]:35157)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cQHHE-0003MQ-9e
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 12:29:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cQHHB-0003PT-3Y
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 12:29:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60080)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cQHHA-0003OX-SW
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 12:29:01 -0500
Date: Sun, 8 Jan 2017 15:28:55 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170108172855.GX3315@thinpad.lan.raisama.net>
References: <20170108171330.11129-1-ehabkost@redhat.com>
	<148389598764.199.18070153688871991941@790289a7ca88>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <148389598764.199.18070153688871991941@790289a7ca88>
Subject: Re: [Qemu-devel] [PATCH v2 0/2] Allow migration with invtsc if TSC
 frequency is explicitly set
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: no-reply@patchew.org
Cc: famz@redhat.com, qemu-devel@nongnu.org, haozhong.zhang@intel.com, kvm@vger.kernel.org, mst@redhat.com, libvir-list@redhat.com, mtosatti@redhat.com, imammedo@redhat.com, pbonzini@redhat.com, jdenemar@redhat.com

On Sun, Jan 08, 2017 at 09:19:49AM -0800, no-reply@patchew.org wrote:
> Hi,
> 
> Your series failed automatic build test. Please find the testing commands and
> their output below. If you have docker installed, you can probably reproduce it
> locally.
> 
> Type: series
> Message-id: 20170108171330.11129-1-ehabkost@redhat.com
> Subject: [Qemu-devel] [PATCH v2 0/2] Allow migration with invtsc if TSC frequency is explicitly set

Ouch. I simply removed patches 3/4 and 4/4 from the series, and
didn't notice there was a mistake in patch 1/2 corrected by patch
4/4 in v1. I will fix it and send v3, sorry for the noise.

-- 
Eduardo
