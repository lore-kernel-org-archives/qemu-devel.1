Received: from eggs.gnu.org ([2001:4830:134:3::10]:53898)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cc9OT-0004RD-4d
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 06:29:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cc9OS-0001I8-2v
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 06:29:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45886)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cc9OR-0001Hv-UP
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 06:29:36 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1DD034DD7E
	for <qemu-devel@nongnu.org>; Fri, 10 Feb 2017 11:29:36 +0000 (UTC)
References: <1486722639-6586-1-git-send-email-thuth@redhat.com>
	<9c13ba42-4a67-a358-3c53-78b98111e530@redhat.com>
	<fb44c900-d590-6dd0-1c17-e50273ce8cfe@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <eb9eb18f-67f2-c6cb-99b8-8557587e411a@redhat.com>
Date: Fri, 10 Feb 2017 12:29:35 +0100
MIME-Version: 1.0
In-Reply-To: <fb44c900-d590-6dd0-1c17-e50273ce8cfe@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] Add a blog post with the presentations
 from the FOSDEM 2017
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org



On 10/02/2017 12:28, Thomas Huth wrote:
> On 10.02.2017 12:24, Paolo Bonzini wrote:
>>
>>
>> On 10/02/2017 11:30, Thomas Huth wrote:
>>> +During last weekend, on February 4th and 5th, the
>>> +[FOSDEM 2017](https://fosdem.org/2017/) conference took place in Brussels,
>>> +which featured a [Virtualisation and IaaS
>>> +track](https://fosdem.org/2017/schedule/track/virtualisation_and_iaas/).
>>> +
>>> +Some people of the QEMU community attended, and the videos of the
>>> +presenters are now available online, too:
>>
>> Grammar nits:
>>
>> Over the last weekend, on February 4th and 5th, the
>> [FOSDEM 2017](https://fosdem.org/2017/) conference took place in Brussels.
>>
>> Some people of the QEMU community attended the [Virtualisation and IaaS
>> track](https://fosdem.org/2017/schedule/track/virtualisation_and_iaas/),
>> and the videos of their presentations are now available online, too:
>>
>> (Again, nothing really serious, just experimenting with the process).  Ok?
> 
> Sure, that's fine for me, too. Feel free to edit my post directly, or do
> you prefer if I send a v2 instead?

Fixed and applied, thanks (and considering giving you push access to
qemu-web ;)).

Paolo
