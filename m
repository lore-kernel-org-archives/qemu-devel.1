Received: from eggs.gnu.org ([2001:4830:134:3::10]:40733)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.ibm.com>) id 1fIKcx-0007zr-5p
	for qemu-devel@nongnu.org; Mon, 14 May 2018 17:03:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.ibm.com>) id 1fIKct-0005Vm-5Y
	for qemu-devel@nongnu.org; Mon, 14 May 2018 17:03:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58552
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.ibm.com>)
	id 1fIKcs-0005Tq-Vi
	for qemu-devel@nongnu.org; Mon, 14 May 2018 17:03:23 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w4EKxFqO065598
	for <qemu-devel@nongnu.org>; Mon, 14 May 2018 17:03:20 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2hyh2aa4an-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 14 May 2018 17:03:20 -0400
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.ibm.com>;
	Mon, 14 May 2018 17:03:20 -0400
References: <20180219141259.26526-1-danielhb@linux.vnet.ibm.com>
	<eebc1ad7-2191-d9cc-81fd-5fefa9e3b1c8@linux.vnet.ibm.com>
	<87tvsfxkuq.fsf@dusky.pond.sub.org> <87efie1v65.fsf@dusky.pond.sub.org>
From: Daniel Henrique Barboza <danielhb@linux.ibm.com>
Date: Mon, 14 May 2018 18:03:14 -0300
MIME-Version: 1.0
In-Reply-To: <87efie1v65.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <ab7b28df-747b-0294-2c8f-2b7617a8915e@linux.ibm.com>
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
To: Markus Armbruster <armbru@redhat.com>, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, mdroth@linux.vnet.ibm.com



On 05/14/2018 05:46 AM, Markus Armbruster wrote:
> Markus Armbruster <armbru@redhat.com> writes:
>
>> Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com> writes:
>>
>>> Ping
>> Michael, you reviewed v4 (at least in part), can you have a look?
> Have these patches fallen through the cracks?
>
Should I re-send it? Not sure if this is applicable in the current code 
base anymore.



Daniel
