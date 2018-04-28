Received: from eggs.gnu.org ([2001:4830:134:3::10]:39489)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fCFZT-0003OR-MW
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 22:26:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fCFZQ-0001gM-J9
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 22:26:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33890 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fCFZQ-0001gE-Ef
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 22:26:40 -0400
Date: Sat, 28 Apr 2018 10:26:34 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180428022634.GH13269@xz-mi>
References: <20180427173416.19233-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180427173416.19233-1-dgilbert@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] migration: update docs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, bala24@linux.vnet.ibm.com, eblake@redhat.com, quintela@redhat.com

On Fri, Apr 27, 2018 at 06:34:16PM +0100, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> Update the migration docs:
> 
> Among other changes:
>   * Added a general list of advice for device authors
>   * Reordered the section on conditional state (subsections etc)
>     into the order we prefer.
>   * Add a note about firmware
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

After other comments addressed, please pick mine:

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu
