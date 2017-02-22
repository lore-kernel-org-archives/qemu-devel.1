Received: from eggs.gnu.org ([2001:4830:134:3::10]:55024)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cgbZg-0006aW-Sy
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 13:23:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cgbZd-00033c-Pi
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 13:23:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45596)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cgbZd-00032v-JO
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 13:23:33 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C49AC80468
	for <qemu-devel@nongnu.org>; Wed, 22 Feb 2017 18:23:33 +0000 (UTC)
Received: from localhost (ovpn-116-33.gru2.redhat.com [10.97.116.33])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5719D899E0
	for <qemu-devel@nongnu.org>; Wed, 22 Feb 2017 18:23:33 +0000 (UTC)
Date: Wed, 22 Feb 2017 15:23:31 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170222182331.GC28403@thinpad.lan.raisama.net>
References: <20170119210449.11991-1-ehabkost@redhat.com>
	<20170119210449.11991-4-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170119210449.11991-4-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/6] i386: Rename X86CPU::host_features to
 X86CPU::max_features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

On Thu, Jan 19, 2017 at 07:04:46PM -0200, Eduardo Habkost wrote:
> Rename the field and add a small comment to make its purpose
> clearer.
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Applied to x86-next.

-- 
Eduardo
