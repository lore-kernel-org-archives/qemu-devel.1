Received: from eggs.gnu.org ([2001:4830:134:3::10]:60198)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pradeep.jagadeesh@huawei.com>) id 1dJFzf-0001St-B3
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 05:14:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pradeep.jagadeesh@huawei.com>) id 1dJFzc-0002A1-6v
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 05:14:11 -0400
Received: from lhrrgout.huawei.com ([194.213.3.17]:13596)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <pradeep.jagadeesh@huawei.com>) id 1dJFzb-000294-Ss
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 05:14:08 -0400
References: <1494405683-20877-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<1494405683-20877-5-git-send-email-pradeep.jagadeesh@huawei.com>
	<6a035cd9-34f9-c1f5-e986-404daf941641@redhat.com>
	<57a24e21-0864-16d3-1bce-ad801875ea9f@huawei.com>
	<2c0e99ce-f3cb-90e8-baed-8fad9d39455b@redhat.com>
	<20170517182938.0c7f366e@bahia.lan>
	<6df407d5-4145-2e90-a7eb-b047819ceb75@redhat.com>
	<e1d5b2d3-bfe7-4fac-03f7-bbfbd5de10fe@huawei.com>
	<20170608184915.20056e6c@bahia.ttt.fr.ibm.com>
	<d08e5a11-0b75-a111-40c4-2f09f37404b1@huawei.com>
	<20170609110741.5ef3e49d@bahia.ttt.fr.ibm.com>
From: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
Message-ID: <09cf094d-55ce-ee3c-6dcc-dd0eee894d8a@huawei.com>
Date: Fri, 9 Jun 2017 11:13:50 +0200
MIME-Version: 1.0
In-Reply-To: <20170609110741.5ef3e49d@bahia.ttt.fr.ibm.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 4/4] fsdev: QMP interface for throttling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: Eric Blake <eblake@redhat.com>, jani kokkonen <jani.kokkonen@huawei.com>, alberto garcia <berto@igalia.com>, qemu-devel@nongnu.org, Pradeep Jagadeesh <pradeepkiruvale@gmail.com>

On 6/9/2017 11:07 AM, Greg Kurz wrote:
>   GEN     qmp-commands.h
> /tmp/qemu-test/src/qapi-schema.json:85: No such file or directory: qapi/fsdev.json
> Makefile:438: recipe for target 'qmp-commands.h' failed
>
> Please fix that.
Ho ok, I will have a look.
How are you trying to compile, using "make docker" options?


Thanks
Pradeep
