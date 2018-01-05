Received: from eggs.gnu.org ([2001:4830:134:3::10]:59298)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eXPWJ-0002ii-34
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 05:46:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eXPWF-0005RK-6u
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 05:46:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33560)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1eXPWF-0005Qd-0S
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 05:46:35 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E6F3180474
	for <qemu-devel@nongnu.org>; Fri,  5 Jan 2018 10:46:33 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20180105103843.30526-1-pbonzini@redhat.com> (Paolo Bonzini's
	message of "Fri, 5 Jan 2018 11:38:43 +0100")
References: <20180105103843.30526-1-pbonzini@redhat.com>
Reply-To: quintela@redhat.com
Date: Fri, 05 Jan 2018 11:46:26 +0100
Message-ID: <87vaggoa65.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [qemu-web PATCH] refine spectre blog post
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com

Paolo Bonzini <pbonzini@redhat.com> wrote:
> People were confused about the level of protection provided by host kernel
> updates (which do not exist yet, but I digress).  They were also asking
> whether it will be possible to live migrate from old to new QEMU and get
> the fixes.  Clarify both aspects.
>
> Suggested-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Suggested-by: Juan Quintela <quintela@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Thanks, much better wording.

Reviewed-by: Juan Quintela <quintela@redhat.com>
