Received: from eggs.gnu.org ([2001:4830:134:3::10]:59473)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1erhdS-0004XO-GD
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 05:09:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1erhdP-00010Y-AO
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 05:09:54 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45408 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <abologna@redhat.com>) id 1erhdP-0000yk-6O
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 05:09:51 -0500
Message-ID: <1519985387.3345.48.camel@redhat.com>
From: Andrea Bolognani <abologna@redhat.com>
Date: Fri, 02 Mar 2018 11:09:47 +0100
In-Reply-To: <1519828976.3345.29.camel@redhat.com>
References: <20180226082259.40293-1-aik@ozlabs.ru>
	<1519828976.3345.29.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH qemu v2] qmp: Add qom-list-properties to
 list QOM object properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>

On Wed, 2018-02-28 at 15:42 +0100, Andrea Bolognani wrote:
> I'm going to implement support for this new command in libvirt
> and report back if I run into any issue with the current design,
> but it looks very good so far.

I've posted the RFC implementation to libvir-list:

  https://www.redhat.com/archives/libvir-list/2018-March/msg00042.html

Everything looks solid to me, so FWIW

  Tested-by: Andrea Bolognani <abologna@redhat.com>

-- 
Andrea Bolognani / Red Hat / Virtualization
