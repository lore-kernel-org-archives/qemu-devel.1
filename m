Received: from eggs.gnu.org ([2001:4830:134:3::10]:43774)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.ibm.com>) id 1fIaqO-000851-OT
	for qemu-devel@nongnu.org; Tue, 15 May 2018 10:22:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.ibm.com>) id 1fIaqI-0003Og-T6
	for qemu-devel@nongnu.org; Tue, 15 May 2018 10:22:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59230)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.ibm.com>)
	id 1fIaqI-0003Na-IW
	for qemu-devel@nongnu.org; Tue, 15 May 2018 10:22:18 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w4FEL4l8028403
	for <qemu-devel@nongnu.org>; Tue, 15 May 2018 10:22:17 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2j00sa1qr4-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 15 May 2018 10:22:17 -0400
Received: from localhost
	by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.ibm.com>;
	Tue, 15 May 2018 10:22:12 -0400
References: <20180219141259.26526-1-danielhb@linux.vnet.ibm.com>
	<eebc1ad7-2191-d9cc-81fd-5fefa9e3b1c8@linux.vnet.ibm.com>
	<87tvsfxkuq.fsf@dusky.pond.sub.org> <87efie1v65.fsf@dusky.pond.sub.org>
	<ab7b28df-747b-0294-2c8f-2b7617a8915e@linux.ibm.com>
	<87vabplc56.fsf@dusky.pond.sub.org>
From: Daniel Henrique Barboza <danielhb@linux.ibm.com>
Date: Tue, 15 May 2018 11:22:07 -0300
MIME-Version: 1.0
In-Reply-To: <87vabplc56.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <19ea4ab3-43a3-5f21-754e-6ff7e796a1d0@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v5 0/2] qmp: 'wakeup-suspend-support' in
 query-target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>, mdroth@linux.vnet.ibm.com, qemu-devel@nongnu.org, dgilbert@redhat.com



On 05/15/2018 02:29 AM, Markus Armbruster wrote:
> git-am isn't happy on current master.  The conflicts look simple enough
> for a maintainer to resolve, but that's yet another hurdle.  Best to
> respin, I think (assuming you still want the patches to go in).
Just respinned it to v6. Let's see how that goes.


Daniel
