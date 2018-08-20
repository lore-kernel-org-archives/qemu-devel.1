Received: from eggs.gnu.org ([2001:4830:134:3::10]:59468)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1frimR-0003Uj-H1
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 07:55:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1frimN-0007St-Io
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 07:55:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48810 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1frimN-0007Sc-Do
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 07:55:27 -0400
References: <20180816011903.39816-1-andrew@andrewoates.com>
	<b45d87b9-38ac-427a-8622-ac9c49350511@redhat.com>
	<CAAVLcG6m_x2p4r9dqD6B2qG-Z_G_iTh5rAubS44PRM2-Mqnpkw@mail.gmail.com>
	<f3c28dc7-a16e-1451-5bb6-090c6e13cf84@redhat.com>
	<CAAVLcG6yDfYTVSmWa1Fdw=C6guhMczRFMkU4vAxUaL6ibTAvPg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2d9e7aac-4026-628a-adc5-d2120113551c@redhat.com>
Date: Mon, 20 Aug 2018 13:55:25 +0200
MIME-Version: 1.0
In-Reply-To: <CAAVLcG6yDfYTVSmWa1Fdw=C6guhMczRFMkU4vAxUaL6ibTAvPg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target-i386: fix segment limit check in
 ljmp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Oates <andrew@andrewoates.com>
Cc: rth@twiddle.net, ehabkost@redhat.com, qemu-devel@nongnu.org, Andrew Oates <aoates@google.com>

On 20/08/2018 13:32, Andrew Oates wrote:
> We should just remove the part that
> implies qemu should enforce it from my patch commit message.

Ok, will do.

Paolo
