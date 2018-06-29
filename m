Received: from eggs.gnu.org ([2001:4830:134:3::10]:49929)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fYzqO-0003su-9j
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 16:18:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fYzqL-0001El-59
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 16:18:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42830)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fYzqK-0001DA-Uj
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 16:18:09 -0400
Date: Fri, 29 Jun 2018 17:18:06 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180629201806.GB7451@localhost.localdomain>
References: <20180629195544.34263-1-eblake@redhat.com>
	<20180629195544.34263-3-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180629195544.34263-3-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] qapi: Drop qapi-gen --unmask option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, Michael Roth <mdroth@linux.vnet.ibm.com>, Cleber Rosa <crosa@redhat.com>

On Fri, Jun 29, 2018 at 02:55:44PM -0500, Eric Blake wrote:
> Now that we have useful access to the type name as a comment
> in the generated qapi-introspect.c, we don't need to regenerate
> code with a temporary -u option just to get at type names.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

-- 
Eduardo
