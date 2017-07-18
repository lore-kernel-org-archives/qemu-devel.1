Received: from eggs.gnu.org ([2001:4830:134:3::10]:40721)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liujbjl@linux.vnet.ibm.com>) id 1dXIkt-0000vv-Nr
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 23:01:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liujbjl@linux.vnet.ibm.com>) id 1dXIkq-0001eC-NQ
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 23:00:59 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38303)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liujbjl@linux.vnet.ibm.com>)
	id 1dXIkq-0001bY-E3
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 23:00:56 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6I2wrpp007057
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 23:00:53 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2brqyade31-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 23:00:53 -0400
Received: from localhost
	by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <liujbjl@linux.vnet.ibm.com>;
	Mon, 17 Jul 2017 23:00:52 -0400
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com
	[9.57.199.106])
	by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	v6I30nBU18350150
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 03:00:49 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8EBB828046
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 23:00:43 -0400 (EDT)
Received: from liujing-mac.local (unknown [9.197.255.127])
	by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP id E878B2803D
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 23:00:41 -0400 (EDT)
From: Jing Liu <liujbjl@linux.vnet.ibm.com>
Date: Tue, 18 Jul 2017 11:01:00 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Message-Id: <15fc8a05-daff-d2af-7389-7253cb0b3517@linux.vnet.ibm.com>
Subject: [Qemu-devel] Question for iotests 188, 189 and 087
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi all,

Do you anybody have iotests failure: 188, 189 and 087 of the latest qemu 
upsteam?

I just wondered if it has something wrong with my test machines because 
I have different results with two machines.


Thanks.

Jing
