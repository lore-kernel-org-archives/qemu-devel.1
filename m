Received: from eggs.gnu.org ([2001:4830:134:3::10]:44268)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1ey8xN-0003Kn-O9
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 00:33:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1ey8xK-0002cu-M7
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 00:33:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36856 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1ey8xK-0002cD-H9
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 00:33:02 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 977A08D746
	for <qemu-devel@nongnu.org>; Tue, 20 Mar 2018 04:32:57 +0000 (UTC)
References: <20180320033919-mutt-send-email-mst@kernel.org>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <1e6df744-65d6-745d-81ee-cd5f8f65bd36@redhat.com>
Date: Tue, 20 Mar 2018 06:32:45 +0200
MIME-Version: 1.0
In-Reply-To: <20180320033919-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] pvrdma build with clang fails
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Marcel Apfelbaum <marcel.a@redhat.com>


Hi Michael,

On 20/03/2018 3:40, Michael S. Tsirkin wrote:
> Marcel, could you pls try a pvrdma build with clang?
> It seems to fail due to enum type mismatches.
> I guess this is something worth fixing.
> 

Sure, I will fix it.
Marcel
