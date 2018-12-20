Received: from eggs.gnu.org ([2001:4830:134:3::10]:44043)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gZyHD-0005XH-GP
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 08:22:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gZy1k-0003oy-0E
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 08:06:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44072)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gZy1j-0003nm-Ke
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 08:06:11 -0500
References: <1545227081-213696-1-git-send-email-robert.hu@linux.intel.com>
	<1545227081-213696-2-git-send-email-robert.hu@linux.intel.com>
	<20181219140136.GJ20465@redhat.com>
	<1545265096.44118.3.camel@linux.intel.com>
	<e1b012da-7aac-1063-35ae-0ab3c4c5eb4b@redhat.com>
	<1545310252.44118.5.camel@linux.intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <def96f44-5cf2-c5cb-4bcd-345c87cc9b0b@redhat.com>
Date: Thu, 20 Dec 2018 14:06:05 +0100
MIME-Version: 1.0
In-Reply-To: <1545310252.44118.5.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/2] i386: remove the new CPUID 'PCONFIG'
 from Icelake-Server CPU model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Robert Hoo <robert.hu@linux.intel.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: robert.hu@intel.com, rth@twiddle.net, ehabkost@redhat.com, thomas.lendacky@amd.com, qemu-devel@nongnu.org

On 20/12/18 13:50, Robert Hoo wrote:
>> We should still leave it in the 3.1 machine types.=C2=A0=C2=A0I've jus=
t sent a
>> patch to do the same with MPX.
>>
> I took a look your patch of "Disable MPX support on named CPU models".
> Seems you do the same as I do to PCONFIG. So you agree with my above
> patch?:-)

If you add send a version that keeps it in the 3.1 machine type, I do.

Paolo

> I won't object that keep it in 3.1 machine type as you do to MPX.
>=20
