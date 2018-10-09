Received: from eggs.gnu.org ([2001:4830:134:3::10]:34006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <simon@ruderich.org>) id 1g9qtx-00008U-7S
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 08:14:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <simon@ruderich.org>) id 1g9qtt-00029H-Q3
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 08:14:13 -0400
Received: from zucker2.schokokeks.org ([178.63.68.90]:33547)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <simon@ruderich.org>) id 1g9qtt-000268-IA
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 08:14:09 -0400
Date: Tue, 9 Oct 2018 14:14:06 +0200
From: Simon Ruderich <simon@ruderich.org>
Message-ID: <20181009121406.GA21572@ruderich.org>
References: <abbc398b-0ded-5531-aba5-bd95200c937c@redhat.com>
	<96fa6847da651ffcaf57405b5e8f020ce5c09d6f.1534854457.git.simon@ruderich.org>
	<20180921110205.GA904@ruderich.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <20180921110205.GA904@ruderich.org>
Subject: Re: [Qemu-devel] [PATCH v5 5/6] qmp: add pmemload command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, David Alan Gilbert <dgilbert@redhat.com>, Peter Crosthwaite <crosthwaitepeter@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Fri, Sep 21, 2018 at 01:02:05PM +0200, Simon Ruderich wrote:
> On Tue, Aug 21, 2018 at 02:38:02PM +0200, Simon Ruderich wrote:
>> Hello,
>>
>> I've adapted the patch to error out if a char/block device is
>> used. I think that's the simplest fix for the issue mentioned by
>> Eric Blake.
>>
>> Are the any other issues remaining? All other patches are
>> unchanged, should I resend the whole series?
>
> Hello,
>
> Any news? Anything I can do to get the patches merged?

Hello again,

Any news? I'd really like to get this patchset merged.

Regards
Simon
-- 
+ privacy is necessary
+ using gnupg http://gnupg.org
+ public key id: 0x92FEFDB7E44C32F9
