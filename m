Received: from eggs.gnu.org ([2001:4830:134:3::10]:40559)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gS4hi-0007ON-H7
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 13:36:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gS4hd-0004Un-E0
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 13:36:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55162)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gS4hd-0004NA-0P
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 13:36:49 -0500
References: <20181128153526.10948-1-berrange@redhat.com>
	<165bc19e-8ed2-8979-aea7-0f6031fc6df2@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <959e624a-95a9-1621-2a1c-11109234dbdb@redhat.com>
Date: Wed, 28 Nov 2018 19:36:40 +0100
MIME-Version: 1.0
In-Reply-To: <165bc19e-8ed2-8979-aea7-0f6031fc6df2@redhat.com>
Content-Type: text/plain; charset=utf-8
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
To: Paolo Bonzini <pbonzini@redhat.com>, "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: raimue@macports.org, alex.bennee@linaro.org, Yu Ning <yu.ning@intel.com>, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On 2018-11-28 17:44, Paolo Bonzini wrote:
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
>     47	Paolo Bonzini <pbonzini@redhat.com>
>     44	Michael Roth <mdroth@linux.vnet.ibm.com>
>     13	Thomas Huth <thuth@redhat.com>
>      3	Eric Blake <eblake@redhat.com>
>      2	Daniel P. Berrange <berrange@redhat.com>
>      2	Jeff Cody <jcody@redhat.com>
>      1	Alex Benn=C3=A9e <alex.bennee@linaro.org>
>      1	Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>      1	Fam Zheng <famz@redhat.com>
>      1	Rainer M=C3=BCller <raimue@macports.org>
>      1	Stefan Hajnoczi <stefanha@gmail.com>
>      1	Yu Ning <yu.ning@intel.com>
>=20
> Anybody (especially non-RH people) disagrees with dual-license CC-BY-SA
> 4.0 and GPLv2+?  (So that we can copy from blog posts to manuals)?

FWIW, dual-license is fine for me.

 Thomas
