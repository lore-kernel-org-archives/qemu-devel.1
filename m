Received: from eggs.gnu.org ([2001:4830:134:3::10]:43305)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dskoa-0003MV-Bn
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 03:13:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dskoX-0006HW-4T
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 03:13:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50188)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dskoW-0006Gz-UR
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 03:13:25 -0400
References: <1503049022-14749-1-git-send-email-hare@suse.de>
	<09f093ef-a073-7374-0f40-330febc7c196@redhat.com>
	<04707d3f-118b-aeaa-0c4c-89ccb1475820@redhat.com>
	<150543488598.22700.2165222026626673271@loki>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4672dd08-eed4-914b-f4b3-bf886021cf1b@redhat.com>
Date: Fri, 15 Sep 2017 09:13:19 +0200
MIME-Version: 1.0
In-Reply-To: <150543488598.22700.2165222026626673271@loki>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] scsi-bus: correct responses for INQUIRY
 and REQUEST SENSE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>, Hannes Reinecke <hare@suse.de>, Laszlo Ersek <lersek@redhat.com>
Cc: Hannes Reinecke <hare@suse.com>, qemu-devel@nongnu.org

On 15/09/2017 02:21, Michael Roth wrote:
> Quoting Paolo Bonzini (2017-08-22 08:20:23)
>> On 19/08/2017 00:55, Laszlo Ersek wrote:
>>> Reported-by: Laszlo Ersek <lersek@redhat.com>
>>> Fixes: ded6ddc5a7b95217557fa360913d1213e12d4a6d
>>
>> And also:
>>
>> Cc: qemu-stable@nongnu.org
> 
> FYI patch freeze for v2.10.1 is Sep 25th. Hannes, were you planning to
> resend with the suggested commit msg changes? (Or maybe having a willing
> maintainer add them?)

I'm sending the pull request today or monday.

Paolo
