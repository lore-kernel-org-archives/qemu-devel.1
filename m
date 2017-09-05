Received: from eggs.gnu.org ([2001:4830:134:3::10]:51741)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dp45O-0007M1-PP
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 22:59:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dp45K-0004dn-B2
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 22:59:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38768)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dp45K-0004cf-4N
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 22:59:30 -0400
Date: Tue, 5 Sep 2017 10:59:24 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170905025924.GG22515@lemon.lan>
References: <20170901112829.2571-1-apahim@redhat.com>
	<20170901112829.2571-4-apahim@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170901112829.2571-4-apahim@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v8 03/13] qemu.py: use os.path.null instead
 of /dev/null
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Amador Pahim <apahim@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, ldoktor@redhat.com, ehabkost@redhat.com, stefanha@gmail.com, armbru@redhat.com, mreitz@redhat.com, crosa@redhat.com

On Fri, 09/01 13:28, Amador Pahim wrote:
> For increased portability, let's use os.path.devnull.
> 
> Signed-off-by: Amador Pahim <apahim@redhat.com>

Reviewed-by: Fam Zheng <famz@redhat.com>
