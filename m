Received: from eggs.gnu.org ([2001:4830:134:3::10]:46411)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f6Y9Z-0000xy-1D
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 05:04:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f6Y9T-0005rM-Jj
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 05:04:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39724 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1f6Y9T-0005qu-Ez
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 05:04:19 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9DAF0EBFEE
	for <qemu-devel@nongnu.org>; Thu, 12 Apr 2018 09:04:08 +0000 (UTC)
References: <20180412053444.17801-1-peterx@redhat.com>
	<20180412075514.GA24896@lemon.usersys.redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <74e8f82f-8fa2-e7c8-4a15-ba752b4688c9@redhat.com>
Date: Thu, 12 Apr 2018 11:04:02 +0200
MIME-Version: 1.0
In-Reply-To: <20180412075514.GA24896@lemon.usersys.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] qemu-thread: always keep the posix
 wrapper layer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On 12/04/2018 09:55, Fam Zheng wrote:
> Reviewed-by: Fam Zheng <famz@redhat.com>

Queued, thanks Fam and Peter.

Paolo
