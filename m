Received: from eggs.gnu.org ([2001:4830:134:3::10]:47462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gFyNB-0002rJ-Mq
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 05:25:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gFyN8-0007iy-CF
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 05:25:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53670)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1gFyN8-0007iV-3y
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 05:25:38 -0400
Date: Fri, 26 Oct 2018 14:55:29 +0530 (IST)
From: P J P <ppandit@redhat.com>
In-Reply-To: <5b8a68c1-2787-af0d-959f-e0c9132f7004@oracle.com>
Message-ID: <nycvar.YSQ.7.76.1810261452510.8270@xnncv>
References: <20181025200944.12113-1-ppandit@redhat.com>
	<5b8a68c1-2787-af0d-959f-e0c9132f7004@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH] lsi53c895a: check message length value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ameya More <ameya.more@oracle.com>
Cc: Qemu Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Mark Kanda <mark.kanda@oracle.com>

+-- On Thu, 25 Oct 2018, Ameya More wrote --+
| While Mark and I reported this issue to you, it was actually discovered by 
| Dejvau Security and they should receive credit for reporting this issue. 
| http://www.dejavusecurity.com

I see; Would it be possible to share email-id of the original reporter to 
include in the commit log message?

Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
47AF CE69 3A90 54AA 9045 1053 DD13 3D32 FE5B 041F
