Received: from eggs.gnu.org ([2001:4830:134:3::10]:48829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fsoWn-0001u7-4U
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 08:15:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fsoWi-0002Sh-6E
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 08:15:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59494 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fsoWh-0002Rc-Or
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 08:15:47 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1515126344
	for <qemu-devel@nongnu.org>; Thu, 23 Aug 2018 12:15:47 +0000 (UTC)
References: <20180822145707.GJ3878@lemon.usersys.redhat.com>
	<d8a08241-413f-daf2-5164-45a0e66a69c5@redhat.com>
	<20180823084330.GA6960@lemon.usersys.redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c2bc20c3-f95e-fdcc-5fa4-21a886704740@redhat.com>
Date: Thu, 23 Aug 2018 14:15:42 +0200
MIME-Version: 1.0
In-Reply-To: <20180823084330.GA6960@lemon.usersys.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] virtio_stw_phys_cached crash
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, jasowang@redhat.com

On 23/08/2018 10:43, Fam Zheng wrote:
>> Does this help?
> Nope. The crash happens the same (once you press "Auto Install" at the first
> prompt).

The patch has a typo; I have now sent it properly.

Paolo
