Received: from eggs.gnu.org ([2001:4830:134:3::10]:34401)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eYpPb-0002pM-As
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 03:37:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eYpPY-0007qc-3Q
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 03:37:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60890)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eYpPX-0007q3-Tl
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 03:37:32 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0177AC0587F9
	for <qemu-devel@nongnu.org>; Tue,  9 Jan 2018 08:37:31 +0000 (UTC)
References: <20180104175609.9085-1-pbonzini@redhat.com>
	<20180109021340.GI5443@lemon.usersys.redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5b0335e7-b680-27ff-7dc4-b777271ec448@redhat.com>
Date: Tue, 9 Jan 2018 09:37:21 +0100
MIME-Version: 1.0
In-Reply-To: <20180109021340.GI5443@lemon.usersys.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-web PATCH] add a blog post about "Spectre"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, ehabkost@redhat.com

On 09/01/2018 03:13, Fam Zheng wrote:
> On Thu, 01/04 18:56, Paolo Bonzini wrote:
>> +be required for non-x86 processors.  If so, they will also posted to the
> 
> Hi Paolo, they will also "be" posted?

Thanks!  Pushed the small fix.

Paolo
