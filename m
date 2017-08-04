Received: from eggs.gnu.org ([2001:4830:134:3::10]:36743)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dddQj-0002RA-1a
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 10:19:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ddbR7-0008HJ-Bj
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 08:11:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55428)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1ddbR7-0008FE-3Z
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 08:10:37 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 112F04A707
	for <qemu-devel@nongnu.org>; Fri,  4 Aug 2017 12:10:36 +0000 (UTC)
Date: Fri, 4 Aug 2017 20:10:31 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170804121031.GA1913@lemon>
References: <150181165680.60.17068931498958654477@93e45bedd699>
	<d13bf86c-036d-4178-9d1d-52443ba226b6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d13bf86c-036d-4178-9d1d-52443ba226b6@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 00/22] Clean up around qmp() and hmp()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com

On Fri, 08/04 06:50, Eric Blake wrote:
> On 08/03/2017 08:54 PM, no-reply@patchew.org wrote:
> > Hi,
> > 
> > This series failed automatic build test. Please find the testing commands and
> > their output below. If you have docker installed, you can probably reproduce it
> > locally.
> 
> When will patchew have a syntax for stating dependencies? (Of course, I
> should actually mention those dependencies in my cover letter, not after
> the fact).

I can give it a try this weekend, if it works, it will be announced on this
list.

Fam
