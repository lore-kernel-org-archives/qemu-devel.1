Received: from eggs.gnu.org ([2001:4830:134:3::10]:38685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fWR0b-0002Ul-8v
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 14:42:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fWR0Y-0004fd-73
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 14:42:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34148)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fWR0Y-0004fX-0z
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 14:42:06 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0E91E369D1
	for <qemu-devel@nongnu.org>; Fri, 22 Jun 2018 18:42:05 +0000 (UTC)
Date: Fri, 22 Jun 2018 15:42:03 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180622184203.GD7451@localhost.localdomain>
References: <1529550907-26824-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529550907-26824-1-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3] hw/i386: Deprecate the machine types
 pc-0.10 and pc-0.11
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>

On Thu, Jun 21, 2018 at 05:15:07AM +0200, Thomas Huth wrote:
> The oldest machine type which is still used in a still maintained distro
> is a pc-0.12 based machine type in RHEL6, so everything that is older
> than pc-0.12 should not be used anymore. Thus let's deprecate pc-0.10
> and pc-0.11 so that we can finally remove them in a future release.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

-- 
Eduardo
