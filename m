Received: from eggs.gnu.org ([2001:4830:134:3::10]:58047)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gS3Sp-0005PR-S2
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 12:17:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gS3Sn-0000hg-Qb
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 12:17:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33032)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gS3Sn-0008SX-DW
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 12:17:25 -0500
References: <20181128153526.10948-1-berrange@redhat.com>
	<165bc19e-8ed2-8979-aea7-0f6031fc6df2@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0d523de7-a6ca-7c54-c4b4-65ec1bf6be2c@redhat.com>
Date: Wed, 28 Nov 2018 11:16:58 -0600
MIME-Version: 1.0
In-Reply-To: <165bc19e-8ed2-8979-aea7-0f6031fc6df2@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu-web PATCH] Document how to test the site
 with jekyll locally
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, raimue@macports.org, alex.bennee@linaro.org, Yu Ning <yu.ning@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>

On 11/28/18 10:44 AM, Paolo Bonzini wrote:
> On 28/11/18 16:35, Daniel P. Berrang=C3=A9 wrote:
>> Add a README file that tells people this is a jekyll based static
>> website, and shows people how to run jekyll for testing purposes.
>>
>> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>> ---
>>
>> NB, we should really mention a license in the README too, but I don't
>> see info about what license we consider qemu-web to be covered by...
>=20
>       3	Eric Blake <eblake@redhat.com>

>=20
> Anybody (especially non-RH people) disagrees with dual-license CC-BY-SA
> 4.0 and GPLv2+?  (So that we can copy from blog posts to manuals)?

For the avoidance of doubt, no disagreement with the proposal in regards=20
to my edits (even if Red Hat can step in and make a broader statement on=20
my behalf).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
