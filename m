Received: from eggs.gnu.org ([2001:4830:134:3::10]:60043)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eZ0DR-00016O-AN
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 15:09:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eZ0DO-0004nB-JU
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 15:09:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:32826)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1eZ0DO-0004mP-Br
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 15:09:42 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 97ABBC057F91
	for <qemu-devel@nongnu.org>; Tue,  9 Jan 2018 20:09:41 +0000 (UTC)
Date: Tue, 9 Jan 2018 18:09:39 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180109200939.GD18022@localhost.localdomain>
References: <1513613438-11017-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1513613438-11017-1-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] scripts: Remove fixed entries from the
 device-crash-test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org

On Mon, Dec 18, 2017 at 05:10:38PM +0100, Thomas Huth wrote:
> These are crashes / errors which have been fixed already in the past
> months. We can remove these from the device-crash-test script now.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Queued on machine-next.  Sorry for the long delay.

-- 
Eduardo
