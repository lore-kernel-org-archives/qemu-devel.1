Received: from eggs.gnu.org ([2001:4830:134:3::10]:54731)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1er6nA-0004Tl-4O
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 13:49:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1er6n7-0005pz-3C
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 13:49:28 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54956 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1er6n6-0005pN-UT
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 13:49:25 -0500
References: <1519439425-27883-1-git-send-email-babu.moger@amd.com>
	<1519439425-27883-2-git-send-email-babu.moger@amd.com>
	<20180228173813.GA8418@flask>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8df70311-a3fd-f27f-6054-9076fc3f23e3@redhat.com>
Date: Wed, 28 Feb 2018 12:49:13 -0600
MIME-Version: 1.0
In-Reply-To: <20180228173813.GA8418@flask>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/5] target/i386: Fix a minor typo found
 while reviwing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Babu Moger <babu.moger@amd.com>
Cc: ehabkost@redhat.com, kvm@vger.kernel.org, mtosatti@redhat.com, Gary.Hook@amd.com, qemu-devel@nongnu.org, pbonzini@redhat.com, pixo@polepetko.eu, rth@twiddle.net

On 02/28/2018 11:38 AM, Radim Kr=C4=8Dm=C3=A1=C5=99 wrote:
> 2018-02-23 21:30-0500, Babu Moger:

In the subject line: s/reviwing/reviewing/  [It's never a good sign when=20
a fix claiming to fix a typo introduces a typo ;) ]

Or go for a shorter subject:
  target/i386: Fix a minor typo

>> Changed KVM_CPUID_FLAG_SIGNIFCANT_INDEX to KVM_CPUID_FLAG_SIGNIFICANT_=
INDEX
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
