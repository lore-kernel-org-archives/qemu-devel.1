Received: from eggs.gnu.org ([2001:4830:134:3::10]:38722)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gS2wV-0007eE-Ln
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 11:44:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gS2wQ-0004AE-TK
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 11:44:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53046)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gS2wQ-00049l-Mj
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 11:43:58 -0500
References: <cover.1542290622.git.simon@ruderich.org>
	<0e061333411f8e64a6e53f14c4c067e5e3e1c91e.1542290622.git.simon@ruderich.org>
	<87r2f5fke5.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e343f966-ef6d-73d1-6bc2-f1801df1ba03@redhat.com>
Date: Wed, 28 Nov 2018 10:43:56 -0600
MIME-Version: 1.0
In-Reply-To: <87r2f5fke5.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v8 6/7] qmp: add pmemload command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, Simon Ruderich <simon@ruderich.org>
Cc: qemu-devel@nongnu.org, Peter Crosthwaite <crosthwaitepeter@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, David Alan Gilbert <dgilbert@redhat.com>, Richard Henderson <rth@twiddle.net>

On 11/28/18 6:37 AM, Markus Armbruster wrote:
...
> 
> @offset and @size feel a bit like overengineering to me.  If this work
> was still at the design stage, I'd advise to start without them, then
> see whether there's a genuine need.  At v5, I'm li
> 
> 

Was there intended to be more to this message?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
